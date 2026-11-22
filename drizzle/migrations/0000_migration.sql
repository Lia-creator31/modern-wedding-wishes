CREATE TABLE public.wishes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL CHECK (char_length(btrim(name)) BETWEEN 1 AND 60),
  attend text NOT NULL DEFAULT 'Hadir' CHECK (attend IN ('Hadir', 'Tidak Hadir', 'Masih Ragu')),
  guests integer NOT NULL DEFAULT 1 CHECK (guests BETWEEN 1 AND 10),
  message text NOT NULL CHECK (char_length(btrim(message)) BETWEEN 1 AND 500),
  created_at timestamptz NOT NULL DEFAULT now()
);
GRANT SELECT, INSERT ON public.wishes TO anon, authenticated;
GRANT ALL ON public.wishes TO service_role;
ALTER TABLE public.wishes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read wishes" ON public.wishes FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY "Anyone can send a wish" ON public.wishes FOR INSERT TO anon, authenticated WITH CHECK (true);
CREATE INDEX wishes_created_at_idx ON public.wishes (created_at DESC);
ALTER PUBLICATION supabase_realtime ADD TABLE public.wishes;

INSERT INTO public.wishes (name, attend, guests, message, created_at) VALUES
('Rina & Keluarga', 'Hadir', 3, 'Barakallahu lakuma wa baraka ''alaikuma wa jama''a bainakuma fii khair. Semoga menjadi keluarga sakinah, mawaddah, warahmah. Aamiin 🤍', now() - interval '3 days'),
('Dimas Pratama', 'Hadir', 2, 'Selamat menempuh hidup baru, sahabatku! Akhirnya sampai juga di hari bahagia ini. Semoga langgeng sampai kakek nenek.', now() - interval '2 days 5 hours'),
('Bu Siti Aminah', 'Masih Ragu', 1, 'Turut berbahagia atas pernikahan kalian. Semoga Allah senantiasa melimpahkan keberkahan dan dikaruniai keturunan yang sholeh dan sholehah.', now() - interval '2 days'),
('Andi Wijaya', 'Tidak Hadir', 1, 'Mohon maaf belum bisa hadir karena sedang di luar kota. Doa terbaik dari jauh, semoga acaranya lancar dan penuh kebahagiaan!', now() - interval '1 day 8 hours'),
('Tim Kantor Divisi Desain', 'Hadir', 6, 'Happy wedding! Semoga cinta kalian terus tumbuh seindah taman bunga. Ditunggu traktirannya ya 😄', now() - interval '20 hours'),
('Nadia Putri', 'Hadir', 2, 'Masya Allah, cantik dan ganteng sekali. Semoga pernikahannya diberkahi, saling menguatkan dalam suka dan duka.', now() - interval '6 hours'),
('Pak Hendra Gunawan', 'Hadir', 2, 'Selamat berbahagia ananda berdua. Jadikan rumah tangga sebagai ladang ibadah. Doa kami menyertai.', now() - interval '2 hours');