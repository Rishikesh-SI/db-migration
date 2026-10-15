-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: ix_ttmum_hero_rating_wn
-- Type: INDEX

-- Name: ix_ttmum_hero_rating_wn; Type: INDEX; Schema: labmi; Owner: -
--

CREATE INDEX ix_ttmum_hero_rating_wn ON labmi.labmi_hero_rating USING btree (entity_role_map_id);


--
