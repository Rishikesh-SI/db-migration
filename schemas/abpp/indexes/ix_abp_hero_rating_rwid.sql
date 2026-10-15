-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_hero_rating_rwid
-- Type: INDEX

-- Name: ix_abp_hero_rating_rwid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_hero_rating_rwid ON abpp.abp_hero_rating USING btree (rating_week_id);


--
