-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labw88.labw88_hero_rating USING btree (rating_week_id);


--
