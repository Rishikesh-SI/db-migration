-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labsrk; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labsrk.labsrk_hero_rating USING btree (rating_week_id);


--
