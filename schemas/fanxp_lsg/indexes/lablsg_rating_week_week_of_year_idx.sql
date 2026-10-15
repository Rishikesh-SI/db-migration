-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_rating_week_week_of_year_idx
-- Type: INDEX

-- Name: lablsg_rating_week_week_of_year_idx; Type: INDEX; Schema: fanxp_lsg; Owner: -
--

CREATE INDEX lablsg_rating_week_week_of_year_idx ON fanxp_lsg.lablsg_rating_week USING btree (week_of_year);


--
