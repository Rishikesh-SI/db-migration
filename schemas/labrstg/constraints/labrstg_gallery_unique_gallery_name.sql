-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_gallery unique_gallery_name
-- Type: CONSTRAINT

-- Name: labrstg_gallery unique_gallery_name; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_gallery
    ADD CONSTRAINT unique_gallery_name UNIQUE (gallery_name);


--
