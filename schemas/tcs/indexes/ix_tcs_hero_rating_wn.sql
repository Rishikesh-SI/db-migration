-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: ix_tcs_hero_rating_wn
-- Type: INDEX

-- Name: ix_tcs_hero_rating_wn; Type: INDEX; Schema: tcs; Owner: -
--

CREATE INDEX ix_tcs_hero_rating_wn ON tcs.tcs_hero_rating USING btree (entity_role_map_id);


--
