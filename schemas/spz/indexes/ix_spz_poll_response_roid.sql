-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_poll_response_roid
-- Type: INDEX

-- Name: ix_spz_poll_response_roid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_poll_response_roid ON spz.spz_poll_response USING btree (response_option_id);


--
