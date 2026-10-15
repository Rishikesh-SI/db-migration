-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ppb_hero_rating_rwid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_hero_rating_rwid ON ppb.ppb_hero_rating USING btree (rating_week_id);


--
