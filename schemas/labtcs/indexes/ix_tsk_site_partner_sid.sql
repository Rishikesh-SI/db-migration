-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: ix_tsk_site_partner_sid
-- Type: INDEX

-- Name: ix_tsk_site_partner_sid; Type: INDEX; Schema: labtcs; Owner: -
--

CREATE INDEX ix_tsk_site_partner_sid ON labtcs.labtcs_site_partner USING btree (site_id);


--
