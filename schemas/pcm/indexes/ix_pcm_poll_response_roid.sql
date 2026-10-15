-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_poll_response_roid
-- Type: INDEX

-- Name: ix_pcm_poll_response_roid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_poll_response_roid ON pcm.pcm_poll_response USING btree (response_option_id);


--
