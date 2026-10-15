-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: ix_ttmum_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_wn; Type: INDEX; Schema: labpr; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_wn ON labpr.labpr_hero_rating USING btree (entity_role_map_id);


--
