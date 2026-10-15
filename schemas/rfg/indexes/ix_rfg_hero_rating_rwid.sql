-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_hero_rating_rwid
-- Type: INDEX

-- Name: ix_rfg_hero_rating_rwid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_hero_rating_rwid ON rfg.rfg_hero_rating USING btree (rating_week_id);


--
