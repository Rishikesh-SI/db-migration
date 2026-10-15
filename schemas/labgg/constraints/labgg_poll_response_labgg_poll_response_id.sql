-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_poll_response labgg_poll_response_id
-- Type: CONSTRAINT

-- Name: labgg_poll_response labgg_poll_response_id; Type: CONSTRAINT; Schema: labgg; Owner: -
--

ALTER TABLE ONLY labgg.labgg_poll_response
    ADD CONSTRAINT labgg_poll_response_id PRIMARY KEY (poll_response_id);


--
