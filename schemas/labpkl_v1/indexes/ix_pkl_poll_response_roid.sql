-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_poll_response_roid
-- Type: INDEX

-- Name: ix_pkl_poll_response_roid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_poll_response_roid ON labpkl_v1.labpkl_v1_poll_response USING btree (response_option_id);


--
