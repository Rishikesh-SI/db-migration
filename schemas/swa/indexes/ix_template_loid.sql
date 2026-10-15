-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_template_loid
-- Type: INDEX

-- Name: ix_template_loid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_template_loid ON swa.swa_template USING btree (layout_id);


--
