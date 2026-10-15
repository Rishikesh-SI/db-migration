-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_hero_rating_wn
-- Type: INDEX

-- Name: ix_upp_hero_rating_wn; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_hero_rating_wn ON upp.upp_hero_rating USING btree (entity_role_map_id);


--
