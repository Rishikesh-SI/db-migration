-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_user_emailid
-- Type: INDEX

-- Name: ix_pcm_user_emailid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_user_emailid ON pcm.pcm_user USING btree (email_id);


--
