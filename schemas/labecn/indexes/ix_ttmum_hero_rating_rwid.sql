-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labecn; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labecn.labecn_hero_rating USING btree (rating_week_id);


--
