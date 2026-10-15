-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_hero_rating_wn
-- Type: INDEX

-- Name: ix_rfg_hero_rating_wn; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_hero_rating_wn ON rfg.rfg_hero_rating USING btree (entity_role_map_id);


--
