-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_poll_response_prid
-- Type: INDEX

-- Name: ix_isl_poll_response_prid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_poll_response_prid ON isl.isl_poll_response USING btree (poll_id);


--
