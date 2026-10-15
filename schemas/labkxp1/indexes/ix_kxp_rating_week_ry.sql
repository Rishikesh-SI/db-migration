-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_rating_week_ry
-- Type: INDEX

-- Name: ix_kxp_rating_week_ry; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_rating_week_ry ON labkxp1.labkxp_rating_week USING btree (rating_year);


--
