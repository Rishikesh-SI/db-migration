-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_hero_rating_rwid
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_rwid; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_rwid ON labmi.labmi_hero_rating USING btree (rating_week_id);


--
