-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: ix_cfc_hero_rating_wn
-- Type: INDEX

-- Name: ix_cfc_hero_rating_wn; Type: INDEX; Schema: cfc; Owner: -
--

CREATE INDEX ix_cfc_hero_rating_wn ON cfc.cfc_hero_rating USING btree (entity_role_map_id);


--
