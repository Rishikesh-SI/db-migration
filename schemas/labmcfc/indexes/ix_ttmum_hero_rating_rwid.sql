-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labmcfc; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labmcfc.labmcfc_hero_rating USING btree (rating_week_id);


--
