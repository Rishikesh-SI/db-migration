-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_template_loid
-- Type: INDEX

-- Name: ix_template_loid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_template_loid ON khi.khi_template USING btree (layout_id);


--
