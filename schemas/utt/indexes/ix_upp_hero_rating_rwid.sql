-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: ix_upp_hero_rating_rwid
-- Type: INDEX

-- Name: ix_upp_hero_rating_rwid; Type: INDEX; Schema: utt; Owner: -
--

CREATE INDEX ix_upp_hero_rating_rwid ON utt.utt_hero_rating USING btree (rating_week_id);


--
