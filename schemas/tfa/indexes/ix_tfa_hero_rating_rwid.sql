-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_hero_rating_rwid
-- Type: INDEX

-- Name: ix_tfa_hero_rating_rwid; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_hero_rating_rwid ON tfa.tfa_hero_rating USING btree (rating_week_id);


--
