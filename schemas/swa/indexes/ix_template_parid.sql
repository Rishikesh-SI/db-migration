-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: ix_template_parid
-- Type: INDEX

-- Name: ix_template_parid; Type: INDEX; Schema: swa; Owner: -
--

CREATE INDEX ix_template_parid ON swa.swa_template USING btree (parent_id);


--
