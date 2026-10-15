-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: ix_template_pid
-- Type: INDEX

-- Name: ix_template_pid; Type: INDEX; Schema: khi; Owner: -
--

CREATE INDEX ix_template_pid ON khi.khi_template USING btree (page_id);


--
