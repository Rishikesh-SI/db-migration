-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_hero_rating_rwid
-- Type: INDEX

-- Name: ix_upp_hero_rating_rwid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_hero_rating_rwid ON upp.upp_hero_rating USING btree (rating_week_id);


--
