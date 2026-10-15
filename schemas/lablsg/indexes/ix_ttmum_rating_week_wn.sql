-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg
-- Object: ix_ttmum_rating_week_wn
-- Type: INDEX

-- Name: ix_ttmum_rating_week_wn; Type: INDEX; Schema: lablsg; Owner: -
--

CREATE INDEX ix_ttmum_rating_week_wn ON lablsg.lablsg_rating_week USING btree (week_number);


--
