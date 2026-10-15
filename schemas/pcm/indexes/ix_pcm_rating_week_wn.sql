-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_rating_week_wn
-- Type: INDEX

-- Name: ix_pcm_rating_week_wn; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_rating_week_wn ON pcm.pcm_rating_week USING btree (week_number);


--
