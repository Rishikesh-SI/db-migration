-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_poll labpkl_poll_id
-- Type: CONSTRAINT

-- Name: labpkl_v1_poll labpkl_poll_id; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.labpkl_v1_poll
    ADD CONSTRAINT labpkl_poll_id PRIMARY KEY (poll_id);


--
