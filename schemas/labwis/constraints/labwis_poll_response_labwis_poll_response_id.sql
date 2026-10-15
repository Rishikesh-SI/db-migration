-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_poll_response labwis_poll_response_id
-- Type: CONSTRAINT

-- Name: labwis_poll_response labwis_poll_response_id; Type: CONSTRAINT; Schema: labwis; Owner: -
--

ALTER TABLE ONLY labwis.labwis_poll_response
    ADD CONSTRAINT labwis_poll_response_id PRIMARY KEY (poll_response_id);


--
