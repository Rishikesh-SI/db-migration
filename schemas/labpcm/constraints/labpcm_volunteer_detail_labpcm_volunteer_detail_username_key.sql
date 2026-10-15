-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_volunteer_detail labpcm_volunteer_detail_username_key
-- Type: CONSTRAINT

-- Name: labpcm_volunteer_detail labpcm_volunteer_detail_username_key; Type: CONSTRAINT; Schema: labpcm; Owner: -
--

ALTER TABLE ONLY labpcm.labpcm_volunteer_detail
    ADD CONSTRAINT labpcm_volunteer_detail_username_key UNIQUE (username);


--
