-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_rating_week_ry
-- Type: INDEX

-- Name: ix_stn_rating_week_ry; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_rating_week_ry ON stn.stn_rating_week USING btree (rating_year);


--
