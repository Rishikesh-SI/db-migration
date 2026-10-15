-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: ix_tfa_hero_rating_wn
-- Type: INDEX

-- Name: ix_tfa_hero_rating_wn; Type: INDEX; Schema: tfa; Owner: -
--

CREATE INDEX ix_tfa_hero_rating_wn ON tfa.tfa_hero_rating USING btree (entity_role_map_id);


--
