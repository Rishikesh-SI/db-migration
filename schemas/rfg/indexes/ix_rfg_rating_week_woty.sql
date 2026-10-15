-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_rating_week_woty
-- Type: INDEX

-- Name: ix_rfg_rating_week_woty; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_rating_week_woty ON rfg.rfg_rating_week USING btree (week_of_year);


--
