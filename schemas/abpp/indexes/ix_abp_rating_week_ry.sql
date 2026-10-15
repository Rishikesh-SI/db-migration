-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_rating_week_ry
-- Type: INDEX

-- Name: ix_abp_rating_week_ry; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_rating_week_ry ON abpp.abp_rating_week USING btree (rating_year);


--
