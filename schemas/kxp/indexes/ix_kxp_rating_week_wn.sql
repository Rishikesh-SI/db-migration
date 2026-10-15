-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_rating_week_wn
-- Type: INDEX

-- Name: ix_kxp_rating_week_wn; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_rating_week_wn ON kxp.kxp_rating_week USING btree (week_number);


--
