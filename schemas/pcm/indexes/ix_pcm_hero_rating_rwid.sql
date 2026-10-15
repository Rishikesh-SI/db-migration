-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: ix_pcm_hero_rating_rwid
-- Type: INDEX

-- Name: ix_pcm_hero_rating_rwid; Type: INDEX; Schema: pcm; Owner: -
--

CREATE INDEX ix_pcm_hero_rating_rwid ON pcm.pcm_hero_rating USING btree (rating_week_id);


--
