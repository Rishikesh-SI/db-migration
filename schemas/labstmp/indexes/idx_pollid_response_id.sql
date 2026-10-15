-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: idx_pollid_response_id
-- Type: INDEX

-- Name: idx_pollid_response_id; Type: INDEX; Schema: labstmp; Owner: -
--

CREATE INDEX idx_pollid_response_id ON labstmp.labstmp_poll_response USING btree (poll_id, response_option_id);


--
