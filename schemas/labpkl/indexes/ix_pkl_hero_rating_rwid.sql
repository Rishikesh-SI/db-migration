-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_hero_rating_rwid
-- Type: INDEX

-- Name: ix_pkl_hero_rating_rwid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_hero_rating_rwid ON labpkl.labpkl_hero_rating USING btree (rating_week_id);


--
