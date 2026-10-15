-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_hero_rating_wn
-- Type: INDEX

-- Name: ix_pbl_hero_rating_wn; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_hero_rating_wn ON pbl.pbl_hero_rating USING btree (entity_role_map_id);


--
