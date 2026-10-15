-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: ix_gpn_notification_payload_cdate
-- Type: INDEX

-- Name: ix_gpn_notification_payload_cdate; Type: INDEX; Schema: gpn; Owner: -
--

CREATE INDEX ix_gpn_notification_payload_cdate ON gpn.gpn_notification_payload USING btree (created_date);


--
