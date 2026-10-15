-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_hero_rating_rwid
-- Type: INDEX

-- Name: ix_gsf_hero_rating_rwid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_hero_rating_rwid ON gsf.gsf_hero_rating USING btree (rating_week_id);


--
