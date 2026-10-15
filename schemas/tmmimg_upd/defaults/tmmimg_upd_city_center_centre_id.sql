-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_city_center centre_id
-- Type: DEFAULT

-- Name: tmmimg_upd_city_center centre_id; Type: DEFAULT; Schema: tmmimg_upd; Owner: -
--

ALTER TABLE ONLY tmmimg_upd.tmmimg_upd_city_center ALTER COLUMN centre_id SET DEFAULT nextval('tmmimg_upd.tmmimg_upd_city_center_centre_id_seq'::regclass);


--
