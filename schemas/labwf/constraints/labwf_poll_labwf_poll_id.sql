-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwf
-- Object: labwf_poll labwf_poll_id
-- Type: CONSTRAINT

-- Name: labwf_poll labwf_poll_id; Type: CONSTRAINT; Schema: labwf; Owner: -
--

ALTER TABLE ONLY labwf.labwf_poll
    ADD CONSTRAINT labwf_poll_id PRIMARY KEY (poll_id);


--
