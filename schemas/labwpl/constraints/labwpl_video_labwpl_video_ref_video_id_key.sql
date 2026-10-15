-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_video labwpl_video_ref_video_id_key
-- Type: CONSTRAINT

-- Name: labwpl_video labwpl_video_ref_video_id_key; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_video
    ADD CONSTRAINT labwpl_video_ref_video_id_key UNIQUE (ref_video_id);


--
