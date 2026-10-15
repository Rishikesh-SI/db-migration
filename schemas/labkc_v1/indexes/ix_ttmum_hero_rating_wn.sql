-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: ix_ttmum_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_wn; Type: INDEX; Schema: labkc_v1; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_wn ON labkc_v1.labkc_v1_hero_rating USING btree (entity_role_map_id);


--
