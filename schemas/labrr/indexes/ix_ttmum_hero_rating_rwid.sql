-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labrr; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labrr.labrr_hero_rating USING btree (rating_week_id);


--
