-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: ix_tsk_site_partner_sid
-- Type: INDEX

-- Name: ix_tsk_site_partner_sid; Type: INDEX; Schema: tsk; Owner: -
--

CREATE INDEX ix_tsk_site_partner_sid ON tsk.tsk_site_partner USING btree (site_id);


--
