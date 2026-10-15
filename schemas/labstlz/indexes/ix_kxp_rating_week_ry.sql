-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_rating_week_ry
-- Type: INDEX

-- Name: ix_kxp_rating_week_ry; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_rating_week_ry ON labstlz.labstlz_rating_week USING btree (rating_year);


--
