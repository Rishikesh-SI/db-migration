-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_video_upload labpkl_video_upload_id
-- Type: CONSTRAINT

-- Name: labgt_video_upload labpkl_video_upload_id; Type: CONSTRAINT; Schema: labgt_bkp; Owner: -
--

ALTER TABLE ONLY labgt_bkp.labgt_video_upload
    ADD CONSTRAINT labpkl_video_upload_id PRIMARY KEY (video_upload_id);


--
